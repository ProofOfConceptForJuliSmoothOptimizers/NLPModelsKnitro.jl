#!/bin/bash

julia -E 'using Pkg(); Pkg.activate(joinpath("~", "tests", "NLPModelsKnitro")); Pkg.add("NLPModelKnitro"); Pkg.build("NLPModelKnitro"); Pkg.test("NLPModelKnitro")'