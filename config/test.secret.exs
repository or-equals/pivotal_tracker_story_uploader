import Config

config :notion_uploader,
        token_1: "1234",
        token_2: "5678"

config :notion_uploader,
        file_valid: "test_file.txt",
        file_invalid: "test_file_invalid.txt"

config :notion_uploader,
        list:
        [
          %{
            "account_id" => 100,
            "id" => 2000000,
            "kind" => "project",
            "name" => "Test Project"
          },
          %{
            "account_id" => 200,
            "id" => 2000002,
            "kind" => "project",
            "name" => "Test Project 2"
          }
        ]

config :notion_uploader,
        url: "www.sample.com"
