defmodule Uploader do
  def enum() do
    map = %{estimate: 2, owner_ids: [3352514,1426364]}

    Enum.each(parse_headers(), fn story ->
      map = Map.put(map, :name, story)
      formatted_body = Poison.encode!(map)
      HTTPoison.post(
        "#{url_builder()}",
        "#{formatted_body}",
        [{"Content-Type", "application/json"}])
    end)
  end

  defp parse_headers do
    case reader() do
      {:ok, content} ->
        [_, headers] = String.split(content, "\n\n")
        String.split(headers, "\n")

      {:error, content} -> "This is your error: #{content}"
    end
  end

  defp reader do
    File.read("Test_2.txt")
  end

  defp token do
    {:ok, content} = reader()
      [author, _] = String.split(content, "\n\n")
        cond do
          author == "Filip" -> "token=9098827fecd66a81096c400e1f4aa229"
          author == "Josh" -> "token=f77ecb7431c05f212a2d7928e3b5a069"
        end
  end

  def url_builder do
    url = "https://www.pivotaltracker.com/services/v5/projects/2460713/stories?"
    url <> token()
  end

end
