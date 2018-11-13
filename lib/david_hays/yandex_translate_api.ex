defmodule DavidHays.YandexTranslateApi do
  @moduledoc """
  The yandex.translate api
  """

  @url Application.get_env(:david_hays, :translator_url)
  @key Application.get_env(:david_hays, :translator_key)

  use Tesla

  plug(Tesla.Middleware.BaseUrl, @url)
  plug(Tesla.Middleware.JSON)
  plug(Tesla.Middleware.Timeout, timeout: 5_000)
  plug(Tesla.Middleware.Query, key: @key)
  plug(Tesla.Middleware.Query, format: "plain")
  plug(Tesla.Middleware.Retry, delay: 200, max_retries: 2)

  @doc """
  Attempts to translate Russian text into English
  """
  @callback ru_to_en(russian_text :: String.t()) ::
              {:ok, english_text :: String.t()}
              | {:error, :too_long}
              | {:error, :unavailable}
  def ru_to_en(text) when is_binary(text) do
    query = [{:text, text}, {:lang, "ru-en"}]

    with {:ok, :adequate_length} <- validate_length(text),
         {:ok, response} <- get("/translate", query: query),
         result <- handle_response(response) do
      result
    else
      {:error, :too_long} -> {:error, :too_long}
      {:error, _reason} -> {:error, :unavailable}
    end
  end

  defp validate_length(text) do
    case String.codepoints(text) do
      codepoints when length(codepoints) <= 280 ->
        {:ok, :adequate_length}

      _ ->
        {:error, :too_long}
    end
  end

  defp handle_response(%{status: 200, body: %{"text" => results}})
       when is_list(results) do
    {:ok, Enum.random(results)}
  end

  defp handle_response(_failure) do
    {:error, :unavailable}
  end
end
