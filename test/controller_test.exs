defmodule ControllerTest do
  use ExUnit.Case

  alias NotionUploader.Controller

  test "extract_token, Filip" do
    string = Controller.reader(Application.fetch_env!(:notion_uploader, :file_valid))
    assert Controller.extract_token(string) == "?token=1234"
  end

  test "extract_token, invalid" do
    string = Controller.reader(Application.fetch_env!(:notion_uploader, :file_invalid))
    assert Controller.extract_token(string) == "Invalid author"
  end

end
