import Config

config :pivotal_tracker_story_uploader,
        http_adapter: PivotalTrackerStoryUploaderMock

config :pivotal_tracker_story_uploader,
        test_file_1: "test_file_valid_author_1.txt",
        test_file_2: "test_file_valid_author_2.txt",
        test_file_3: "test_file_invalid_author.txt"

config :pivotal_tracker_story_uploader,
        token_1: "sample_token_1",
        token_2: "sample_token_2"

config :pivotal_tracker_story_uploader,
        author_1: "sample_author_1",
        author_2: "sample_author_2"

config :pivotal_tracker_story_uploader,
        owner_id_1: 1234,
        owner_id_2: 5678
