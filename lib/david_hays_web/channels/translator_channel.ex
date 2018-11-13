defmodule DavidHaysWeb.TranslatorChannel do
  use DavidHaysWeb, :channel
  @yandex_translate_api Application.get_env(:david_hays, :translator_api)

  def join("translator:lobby", _payload, socket) do
    {:ok, socket}
  end

  def handle_in("message:new", %{"message" => msg}, socket) do
    case @yandex_translate_api.ru_to_en(msg) do
      {:ok, result} ->
        broadcast(socket, "message:add", %{"eng_message" => result})
        {:reply, :ok, socket}

      {:error, :too_long} ->
        {:reply, {:error, %{reason: "too long"}}, socket}

      {:error, _reason} ->
        {:reply, {:error, %{reason: "unavailable"}}, socket}
    end
  end
end
