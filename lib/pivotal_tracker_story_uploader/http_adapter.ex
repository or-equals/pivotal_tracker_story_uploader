defmodule PivotalTrackerStoryUploader.HttpAdapter do

  @behaviour PivotalTrackerStoryUploader.HttpAdapterBehavior

  defp http_adapter, do: Application.fetch_env!(:pivotal_tracker_story_uploader, :http_adapter)

  def get(url, headers) do
    http_adapter().get(url, headers)
  end

  def post(url, params, headers) do
    http_adapter().post(url, params, headers)
  end

  def process_response_body(body) do
    body
    |> Poison.decode
  end

  def encode_params_to_json(params) do
    params
    |> Poison.encode
  end
end
