hl.layout.register("two_col_special", {
    recalculate = function(ctx)
        local n = #ctx.targets
        if n == 0 then return end

        for i, target in ipairs(ctx.targets) do
            if i == 1 then
                -- First window gets left half
                target:place(ctx:split(ctx.area, "left", 0.5))
            else
                -- Others stack vertically on the righ:t
                local right = ctx:split(ctx.area, "right", 0.5)
                target:place(ctx:row(i - 1, n - 1, right))
            end
        end
    end,
})

