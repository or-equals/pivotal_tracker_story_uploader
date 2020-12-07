defmodule NotionUploader.Api do
  alias NotionUploader.Uploader

  def list_projects do
    case HTTPoison.get(Uploader.url_get()) do
      {:ok, %HTTPoison.Response{body: body}} ->
        {:ok, body} = Poison.decode(body)
        body

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def compare_project_names do
    Enum.find(list_projects(), fn project ->
        Map.get(project, "name") == project_name()
    end)
  end

  def get_project_id do
    map = compare_project_names()
    Map.get(map, "id")
  end

  def project_name do
    {:ok, content} = Uploader.reader()
      [top, _] = String.split(content, "\n\n")
      [_, project_name] = String.split(top, "\n")
      project_name
  end
end
