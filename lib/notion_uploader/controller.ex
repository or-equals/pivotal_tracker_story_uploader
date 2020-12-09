defmodule NotionUploader.Controller do

  @url "https://www.pivotaltracker.com/services/v5/projects"

  def get_api_token(file) do
    file
    |> reader
    |> extract_token
  end

  def reader(file) do
    {:ok, content} = File.read(file)
    content |> String.trim()
  end

  def extract_token(string) do
    [top, _stories] = String.split(string, "\n\n")
    [author, _project, _owners] = String.split(top, "\n")

    cond do
      author == "Filip" ->
        "?token=" <> Application.fetch_env!(:notion_uploader, :token_1)

      author == "Josh" ->
        "?token=" <> Application.fetch_env!(:notion_uploader, :token_2)

      author != "Filip" || author != "Josh" ->
        "Invalid author"
    end
  end


  def get_project_id(url, file) do
    url
    |> url_with_token
    |> list_projects
    |> extract_project_id(file)
  end

  def url_with_token(string) do
    @url <> string
  end

  def list_projects(string) do
    case HTTPoison.get(string) do
      {:ok, %HTTPoison.Response{body: body}} ->
        {:ok, body} = Poison.decode(body)
        body

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def extract_project_id(list, file) do
    Enum.find(list, fn project ->
      Map.get(project, "name") == get_project_name(file)
    end)
    |> Map.get("id")
    |> to_string
  end

  def get_project_name(file) do
    content = reader(file)
      [top, _stories] = String.split(content, "\n\n")
      [_author, project, _owners] = String.split(top, "\n")
      project
  end


  def get_owners(url, file) do
    url
    |> create_url(file)
    |> get_members
    |> modify_members
    |> create_owners_map(file)
    |> get_owner_ids
  end

  def create_url(string, file) do
    content = reader(file)
    @url <> "/" <> string <> "/memberships" <> extract_token(content)
  end

  def get_members(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: body}} ->
        Poison.decode(body)
    end
  end

  def modify_members(list) do
    {:ok, list} = list
      for person <- list do
        Map.merge(%{}, %{
          name: person["person"]["name"],
          id: person["person"]["id"]
        })
    end
  end

  def create_owners_map(list, file) do
    Enum.filter(list, fn member ->
      member.name in get_owners_list(file) end)
  end

  def get_owners_list(file) do
    content = reader(file)
        [top, _stories] = String.split(content, "\n\n")
        [_author, _project, owners] = String.split(top, "\n")

        String.split(owners, ",")
          |> Enum.map(fn owner -> String.trim(owner) end)
  end

  def get_owner_ids(map) do
    for owner <- map do
      owner.id
    end
  end


  def list_stories(file) do
    file
    |> reader
    |> get_stories
  end

  def get_stories(string) do
    [_top, headers] = String.split(string, "\n\n")
    String.split(headers, "\n")
  end


  def url_builder(file) do
    @url
    <> "/"
    <> get_project_id(
          get_api_token(file),
          file
          )
    <> "/stories"
    <> get_api_token(file)
  end

end
