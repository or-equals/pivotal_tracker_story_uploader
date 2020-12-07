defmodule NotionUploader.Parser do
  alias NotionUploader.Uploader

  def get_api_token do
    {:ok, content} = Uploader.reader()
      [top, _] = String.split(content, "\n\n")
      [author, _] = String.split(top, "\n")
        cond do
          author == "Filip" ->
            Application.fetch_env!(:notion_uploader, :key_1)

          author == "Josh" ->
            Application.fetch_env!(:notion_uploader, :key_2)
        end
  end

  def parse_headers do
    case Uploader.reader() do
      {:ok, content} ->
        [_, headers] = String.split(content, "\n\n")
        String.split(headers, "\n")

      {:error, content} -> "This is your error: #{content}"
    end
  end
end
