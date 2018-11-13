defmodule DavidHays.YandexTranslateApiTest do
  use ExUnit.Case
  import Tesla.Mock
  alias DavidHays.YandexTranslateApi

  @too_long String.duplicate("а", 300)

  setup do
    mock_global(fn
      %{query: query} ->
        case Keyword.get(query, :text) do
          "привет" -> json(%{"text" => ["hi"]})
          _any_other -> %{status: 404}
        end
    end)

    :ok
  end

  describe "yandex translate api handling tests" do
    test "success" do
      assert {:ok, "hi"} = YandexTranslateApi.ru_to_en("привет")
    end

    test "error: too long" do
      assert {:error, :too_long} = YandexTranslateApi.ru_to_en(@too_long)
    end

    test "error: unavailable" do
      assert {:error, :unavailable} = YandexTranslateApi.ru_to_en("нет")
    end
  end
end
