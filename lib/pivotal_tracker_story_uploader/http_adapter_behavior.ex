defmodule PivotalTrackerStoryUploader.HttpAdapterBehavior do
  @type url     :: binary()
  @type headers :: [{binary, binary}]

  @callback get(url, headers) :: {:ok, map()}

end
