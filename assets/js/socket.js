import { Socket } from 'phoenix';

const renderMessage = (message) => {
  const messageTemplate = `
    <li class='list-group-item'>
    <b>message: </b>
    ${message}</li>
  `;

  document
    .querySelector('#messages')
    .insertAdjacentHTML('afterbegin', messageTemplate);
};

const socket = new Socket('/socket', { params: { token: window.userToken } });

socket.connect();

const channel = socket.channel('translator:lobby', {});

channel
  .join()
  .receive('ok', (resp) => { console.log('Joined successfully', resp); })
  .receive('error', (resp) => { console.log('Unable to join', resp); });

document
  .querySelector('#new-message')
  .addEventListener('submit', (e) => {
    const form = document.querySelector('#new-message');
    e.preventDefault();

    const messageInput = e
      .target
      .querySelector('#message-content');

    if (!form.disabled && messageInput.value !== '') {
      form.disabled = true;

      channel
        .push('message:new', { message: messageInput.value })
        .receive('ok', () => {
          messageInput.value = '';
          form.disabled = false;
        })
        .receive('error', ({ reason }) => {
          alert(reason);
          form.disabled = false;
          console.log(reason);
        });
    }
  });

channel
  .on('message:add', ({ eng_message }) => {
    console.log('message', eng_message);
    renderMessage(eng_message);
  });

export default socket;
