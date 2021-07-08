using Pkg
Pkg.activate(joinpath("temp_env"))
Pkg.add(["Git", "GitHub"])
Pkg.instantiate()

using Git, GitHub

TEST_RESULTS_FILE = "test_results.log"

# Need to add GITHUB_AUTH to your .bashrc
myauth = GitHub.authenticate(ENV["GITHUB_AUTH"])

function create_gist(authentication)
    gistfile = TEST_RESULTS_FILE
    gist = begin
        open(gistfile, "r") do f
            return println(readlines(f))
        end
    end
    posted_gist = GitHub.create_gist(params = gist, auth = authentication)

    return posted_gist
end

function post_gist_url_to_pr(comment::String; kwargs...)
    api = GitHub.DEFAULT_API
    repo = get_repo(api, ENV["OWNER"], ENV["REPO_NAME"]; kwargs...)
    pull_request = get_pull_request(api, ENV["OWNER"], repo, Int(ENV["PR_NUMBER"]); kwargs...)
    GitHub.create_comment(api, repo, pull_request, comment; kwargs...)
end

function get_pull_request(api::GitHub.GitHubWebAPI, org::String, repo::Repo, pullrequest_id; kwargs...)
    my_params = Dict(:sort => "popularity",
                    :direction => "desc")
    pull_request = PullRequest(GitHub.gh_get_json(api, "/repos/$(org)/$(repo.name)/pulls/$(pullrequest_id)"; params=my_params, kwargs...))
   
    return pull_request
end

post_gist_url_to_pr("Here are the test results: $(create_gist(myauth).html_url)")