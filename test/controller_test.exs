defmodule ControllerTest do
  use ExUnit.Case

  alias NotionUploader.Controller

  test "test get_author, Filip" do
    assert Controller.get_author() == "Filip"
  end

  test "test get_author, invalid" do
    assert Controller.get_author() == "Invalid author"
  end

end
