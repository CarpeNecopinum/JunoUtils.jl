function Juno.render(i::Juno.Inline, f::Function)
    ft = typeof(f)
    mt = ft.name.mt

    meth = methods(f).ms

    if length(meth) == 1
        inputs = meth[1].sig.types[2:end]
        returns = Base.return_types(f, inputs)[1]
        output = Juno.render(i, Text("$(mt.module).$(mt.name) $(Tuple(inputs)) -> $(returns)"))
        if returns === Union{}
            output[:attrs][:class] = ["error"]
        end
        output
    else
        has_failing_method = false
        children = []
        for method in meth
            body = method.sig
            while hasproperty(body, :body)
                body = body.body
            end

            inputs = body.types[2:end]
            returns = Base.return_types(f, inputs)[1]

            intext = length(inputs) == 1 ? string(first(inputs)) : string(Tuple(inputs))

            line = Juno.render(i, Text("$intext -> $(returns)"))
            if returns === Union{}
                line[:attrs][:class] = ["error"]
                has_failing_method = true
            end
            push!(children, line)

        end
        output = Juno.render(i,Juno.Tree(Text("$(mt.module).$(mt.name)"), [""]))
        output[:children] = children
        if has_failing_method
            output[:head][:attrs][:class] = ["error"]
        end
        output
    end
end
