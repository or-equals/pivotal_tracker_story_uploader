defmodule PivotalTrackerStoryUploader.HttpAdapter do

  def get(url, headers) do
    HTTPoison.get(url, headers)
  end

  def post(url, params, headers) do
    HTTPoison.post(url, params, headers)
  end

  def process_response_body(body) do
    body
    |> Poison.decode
  end

  def process_request_body(params) do
    params
    |> Poison.encode
  end
end
