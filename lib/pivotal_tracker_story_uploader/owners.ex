defmodule PivotalTrackerStoryUploader.Owners do

  alias PivotalTrackerStoryUploader.Members
  alias PivotalTrackerStoryUploader.Controller

  def get_owners(file) do
    file
    |> Members.get_members
    |> fetch_owners(file)
    |> fetch_owner_ids
  end

  defp fetch_owners(list, file) do
    Enum.filter(list, fn member ->
      member.name in get_owners_list(file) end)
  end

  defp get_owners_list(file) do
    content = Controller.reader(file)
      [top, _stories] = String.split(content, "\n\n")
      [_author, _project, owners] = String.split(top, "\n")

      String.split(owners, ",")
      |> Enum.map(fn owner -> String.trim(owner) end)
  end

  defp fetch_owner_ids(map) do
    for owner <- map do
      owner.id
    end
  end
end
