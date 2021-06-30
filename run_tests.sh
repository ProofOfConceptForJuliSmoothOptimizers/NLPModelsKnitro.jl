#!/bin/bash

julia -E 'using Pkg; Pkg.activate(joinpath("~", "tests", "NLPModelsKnitro")); Pkg.add("NLPModelsKnitro"); Pkg.build("NLPModelsKnitro"); Pkg.test("NLPModelsKnitro")'