#!/bin/bash

julia -E 'using Pkg; Pkg.activate(joinpath("temp_env", "NLPModelsKnitro")); Pkg.add("NLPModelsKnitro"); Pkg.build("NLPModelsKnitro"); Pkg.test("NLPModelsKnitro")' &> test_results.txt

# Create the gist and create comment on PR:
julia test/send_gist_url.jl


