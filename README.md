# JunoUtils.jl
Tweaks to make working with Juno a bit nicer (to me)

# Currently implemented tweaks:

## Function Rendering

Originally a function just renders as its name in Juno. With JunoUtils, all its methods will be displayed, including their inferred return types. Methods that return `Union{}` (which usually means that they will throw) will be displayed in red, so you'll know about some error a bit earlier.
