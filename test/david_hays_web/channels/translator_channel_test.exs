defmodule DavidHaysWeb.TranslatorChannelTest do
  use DavidHaysWeb.ChannelCase
  import Mox

  @yandex_translate_api Application.get_env(:david_hays, :translator_api)
  @too_long String.duplicate("а", 300)

  setup :verify_on_exit!

  setup do
    {:ok, _, socket} =
      socket(DavidHaysWeb.UserSocket, "user_id", %{some: :assign})
      |> subscribe_and_join(DavidHaysWeb.TranslatorChannel, "translator:lobby")

    {:ok, socket: socket}
  end

  test "successful message", %{socket: socket} do
    allow(@yandex_translate_api, self(), socket.channel_pid)

    @yandex_translate_api
    |> expect(:ru_to_en, fn "привет" -> {:ok, "hi"} end)

    ref = push(socket, "message:new", %{"message" => "привет"})
    assert_reply ref, :ok
    assert_broadcast "message:add", %{"eng_message" => "hi"}
  end

  test "message was too long", %{socket: socket} do
    allow(@yandex_translate_api, self(), socket.channel_pid)

    @yandex_translate_api
    |> expect(:ru_to_en, fn @too_long -> {:error, :too_long} end)

    ref = push(socket, "message:new", %{"message" => @too_long})
    assert_reply ref, :error, %{reason: "too long"}
  end

  test "translate is unavailable", %{socket: socket} do
    allow(@yandex_translate_api, self(), socket.channel_pid)

    @yandex_translate_api
    |> expect(:ru_to_en, fn _ -> {:error, :unavailable} end)

    ref = push(socket, "message:new", %{"message" => "привет"})
    assert_reply ref, :error, %{reason: "unavailable"}
  end
end
