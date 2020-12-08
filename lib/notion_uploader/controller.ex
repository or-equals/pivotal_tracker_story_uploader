defmodule NotionUploader.Controller do

  alias NotionUploader.Uploader
  alias NotionUploader.UrlBuilder

  def get_api_token do
    author = get_author()
      cond do
        author == "Filip" ->
          "?token=" <> Application.fetch_env!(:notion_uploader, :key_1)

        author == "Josh" ->
          "?token=" <> Application.fetch_env!(:notion_uploader, :key_2)

        author != "Filip" || author != "Josh" ->
          IO.puts("Invalid author")
      end
  end

  def get_author do
    case Uploader.reader() do
      {:ok, content} ->
        [top, _] = String.split(content, "\n\n")
        [author, _, _] = String.split(top, "\n")
        author
      {:error, content} -> "This is your error: #{content}"
    end
  end

  def get_stories do
    case Uploader.reader() do
      {:ok, content} ->
        [_, headers] = String.split(content, "\n\n")
        String.split(headers, "\n")

      {:error, content} -> "This is your error: #{content}"
    end
  end

  def list_projects do
    case HTTPoison.get(UrlBuilder.url_get()) do
      {:ok, %HTTPoison.Response{body: body}} ->
        {:ok, body} = Poison.decode(body)
        body

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def compare_project_names do
    Enum.find(list_projects(), fn project ->
        Map.get(project, "name") == get_project_name()
    end)
  end

  def get_project_id do
    map = compare_project_names()
    Map.get(map, "id")
  end

  def get_project_name do
    case Uploader.reader() do
      {:ok, content} ->
        [top, _] = String.split(content, "\n\n")
        [_, project_name, _] = String.split(top, "\n")
        project_name
      {:error, content} -> "This is your error: #{content}"
    end
  end

  def get_member_list do
    case HTTPoison.get(UrlBuilder.url_members()) do
      {:ok, %HTTPoison.Response{body: body}} ->
        Poison.decode(body)
    end
  end

  def modify_member_list do
    {:ok, list} = get_member_list()
      for person <- list do
        map = %{}
        Map.merge(map, %{
          name: person["person"]["name"],
          id: person["person"]["id"]
        })
    end
  end

  def owner_ids do
    for owner <- owners_map() do
      owner.id
    end
  end

  defp owners_map do
    Enum.filter(modify_member_list(), fn member -> member.name in get_owners_list() end)
  end

  def get_owners_list do
    case Uploader.reader() do
      {:ok, content} ->
        [top, _] = String.split(content, "\n\n")
        [_, _, owners] = String.split(top, "\n")

        String.split(owners, ",")
          |> Enum.map(fn owner -> String.trim(owner) end)

      {:error, content} -> "This is your error: #{content}"
    end
  end


end
