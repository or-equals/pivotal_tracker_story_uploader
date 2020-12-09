defmodule NotionUploader.Uploader do

  alias NotionUploader.Controller

  def upload(file) do
    map = %{
      estimate: 2,
      owner_ids: owners(file)
    }

    Enum.each(Controller.list_stories(file), fn story ->
      map = Map.put(map, :name, story)

      formatted_body = Poison.encode!(map)

      HTTPoison.post(
        "#{Controller.url_builder(file)}",
        "#{formatted_body}",
        [{"Content-Type", "application/json"}])
    end)
  end

  def owners(file) do
    file
    |> Controller.get_api_token
    |> Controller.get_project_id(file)
    |> Controller.get_owners(file)
  end

end
