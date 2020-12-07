defmodule ParserTest do
  use ExUnit.Case

  alias NotionUploader.Parser
  alias NotionUploader.Api

  test "Filip" do
    assert Parser.get_api_token() == "?token=9098827fecd66a81096c400e1f4aa229"
  end

  # test "Josh" do
  #   assert Parser.get_api_token() == "?token=f77ecb7431c05f212a2d7928e3b5a069"
  # end

  test "test" do
    assert Api.get_project_id() == 2479568
  end


end
