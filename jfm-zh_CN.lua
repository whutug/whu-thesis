local is_vt, is_qj, is_bj, is_km, is_hwcl

if luatexja.jfont.jfm_feature then
    is_vt = luatexja.jfont.jfm_feature.vert
    is_qj = luatexja.jfont.jfm_feature.quanjiao
    is_bj = luatexja.jfont.jfm_feature.banjiao
    is_km = luatexja.jfont.jfm_feature.kaiming
    is_hwcl = luatexja.jfont.jfm_feature.hwcl
end

if is_hwcl then
    if not is_vt then
        tex.error('JFM feature "hwcl" can only be used in vertical mode')
    end
end

if
    not ((is_qj and not (is_bj or is_km)) or (is_bj and not (is_qj or is_km)) or
        (is_km and not (is_qj or is_bj)))
 then
    tex.error(
        'You must specify ONLY ONE feature among "quanjiao", "banjiao" and ' ..
            '"kaiming"'
    )
end

local function aki(wd, pr, km)
    -- 插入空白量
    local p = pr or 0
    return km and
        (is_bj and {0, wd, 0, priority = {p, -p}} or
            {wd, 0, wd, priority = {p, -p}}) or
        (is_qj and {wd, 0, wd, priority = {p, -p}} or
            {0, wd, 0, priority = {p, -p}})
end

luatexja.jfont.define_jfm {
    version = 3,
    dir = is_vt and 'tate' or 'yoko',
    zw = 1,
    zh = 1,
    kanjiskip = {0.0, 0.25, 0},
    xkanjiskip = {0.25, 0.25, 0.125},
    [0] = {
        align = 'middle',
        left = 0,
        down = 0,
        width = 1,
        height = is_vt and 0.5 or 0.88,
        depth = is_vt and 0.5 or 0.12,
        italic = 0,
        glue = {
            [1] = aki(0.5, -1),
            [3] = aki(0.25, -1)
        }
    },
    [1] = {
        -- 开括号
        chars = {
            '‘',
            '“',
            '〈',
            '《',
            '「',
            '『',
            '【',
            '〔',
            '〖',
            '〘',
            '〝',
            '（',
            '［',
            '｛',
            '｟'
        },
        align = 'right',
        left = 0,
        down = 0,
        width = 0.5,
        height = is_vt and 0.5 or 0.88,
        depth = is_vt and 0.5 or 0.12,
        italic = 0,
        glue = {
            [3] = aki(0.25, -1)
        }
    },
    [2] = {
        -- 闭括号
        chars = {
            '’',
            '”',
            '〉',
            '》',
            '」',
            '』',
            '】',
            '〕',
            '〗',
            '〙',
            '〞',
            '〟',
            '）',
            '］',
            '｝',
            '｠'
        },
        align = 'left',
        left = 0,
        down = 0,
        width = 0.5,
        height = is_vt and 0.5 or 0.88,
        depth = is_vt and 0.5 or 0.12,
        italic = 0,
        glue = {
            [0] = aki(0.5, -1),
            [1] = aki(0.5, -1),
            [3] = aki(0.5, -1),
            [5] = aki(0.5, -1),
            [51] = aki(0.5, -1),
            [52] = aki(0.5, -1)
        }
    },
    [21] = {
        -- 逗号、顿号
        chars = {'、', '，'},
        align = 'left',
        left = 0,
        down = 0,
        width = 0.5,
        height = is_vt and 0.5 or 0.88,
        depth = is_vt and 0.5 or 0.12,
        italic = 0,
        glue = {
            [0] = aki(0.5),
            [1] = aki(0.5),
            [3] = aki(0.5),
            [5] = aki(0.5),
            [51] = aki(0.5),
            [52] = aki(0.5)
        }
    },
    [22] = {
        -- 冒号、分号
        chars = {'：', '；'},
        align = 'left',
        left = 0,
        down = 0,
        width = is_vt and (is_hwcl and 0.5 or 1) or 0.5,
        height = is_vt and 0.5 or 0.88,
        depth = is_vt and 0.5 or 0.12,
        italic = 0,
        glue = {
            [0] = is_vt and (is_hwcl and aki(0.5) or {}) or aki(0.5),
            [1] = is_vt and (is_hwcl and aki(0.5) or {}) or aki(0.5),
            [3] = is_vt and (is_hwcl and aki(0.5) or aki(0.25, 1)) or aki(0.5),
            [5] = is_vt and (is_hwcl and aki(0.5) or {}) or aki(0.5),
            [51] = is_vt and (is_hwcl and aki(0.5) or {}) or aki(0.5),
            [52] = is_vt and (is_hwcl and aki(0.5) or {}) or aki(0.5)
        }
    },
    [3] = {
        -- 间隔号
        chars = {'・', '·'},
        align = 'middle',
        left = 0,
        down = 0,
        width = 0.5,
        height = is_vt and 0.5 or 0.88,
        depth = is_vt and 0.5 or 0.12,
        italic = 0,
        glue = {
            [0] = aki(0.25, -1),
            [1] = aki(0.5, -1),
            [2] = aki(0.25, -1),
            [21] = aki(0.25, -1),
            [22] = aki(0.25, -1),
            [3] = aki(0.5, -1),
            [4] = aki(0.25, -1),
            [41] = aki(0.25, -1),
            [42] = aki(0.25, -1),
            [5] = aki(0.25, -1)
        }
    },
    [4] = {
        -- 句号
        chars = {'。', '．'},
        align = 'left',
        left = 0,
        down = 0,
        width = 0.5,
        height = is_vt and 0.5 or 0.88,
        depth = is_vt and 0.5 or 0.12,
        italic = 0,
        glue = {
            [0] = aki(0.5, 1, true),
            [1] = aki(0.5, 1, true),
            [3] = aki(0.5, 1, true),
            [5] = aki(0.5, 1, true),
            [51] = aki(0.5, 1, true),
            [52] = aki(0.5, 1, true)
        }
    },
    [41] = {
        -- 叹号、问号
        chars = {'！', '？'},
        align = is_vt and 'middle' or 'left',
        left = 0,
        down = 0,
        width = is_vt and 1 or 0.5,
        height = is_vt and 0.5 or 0.88,
        depth = is_vt and 0.5 or 0.12,
        italic = 0,
        glue = {
            [0] = is_vt and {} or aki(0.5, 1, true),
            [1] = is_vt and {} or aki(0.5, 1, true),
            [3] = is_vt and aki(0.25, -1) or aki(0.5, 1, true),
            [5] = is_vt and {} or aki(0.5, 1, true),
            [51] = is_vt and {} or aki(0.5, 1, true),
            [52] = is_vt and {} or aki(0.5, 1, true)
        }
    },
    [42] = {
        -- 复合/连用叹号问号
        chars = {'‼', '⁇', '⁈', '⁉'},
        align = 'middle',
        left = 0,
        down = 0,
        width = 1,
        height = is_vt and 0.5 or 0.88,
        depth = is_vt and 0.5 or 0.12,
        italic = 0,
        glue = {
            [3] = aki(0.25, -1)
        }
    },
    [5] = {
        -- 一字线、省略号、波浪线
        chars = {
            '—', -- U+2014
            '―', -- U+2015
            '‥',
            '…',
            '〜', -- U+301C
            '～' -- U+FF5E
        },
        align = 'middle',
        left = 0,
        down = 0,
        width = 1,
        height = is_vt and 0.5 or 0.88,
        depth = is_vt and 0.5 or 0.12,
        italic = 0,
        glue = {
            [1] = aki(0.5, -1),
            [3] = aki(0.25, -1)
        },
        kern = {
            [5] = 0,
            [51] = 0,
            [52] = 0
        }
    },
    [51] = {
        -- U+2E3A TWO-EM DASH
        chars = {'⸺'},
        align = 'middle',
        left = 0,
        down = 0,
        width = 2,
        height = is_vt and 0.5 or 0.88,
        depth = is_vt and 0.5 or 0.12,
        italic = 0,
        glue = {
            [1] = aki(0.5, -1),
            [3] = aki(0.25, -1)
        },
        kern = {
            [5] = 0,
            [51] = 0,
            [52] = 0
        }
    },
    [52] = {
        -- U+2E3B THREE-EM DASH
        chars = {'⸻'},
        align = 'middle',
        left = 0,
        down = 0,
        width = 3,
        height = is_vt and 0.5 or 0.88,
        depth = is_vt and 0.5 or 0.12,
        italic = 0,
        glue = {
            [1] = aki(0.5, -1),
            [3] = aki(0.25, -1)
        },
        kern = {
            [5] = 0,
            [51] = 0,
            [52] = 0
        }
    },
    [6] = {
        -- box end
        chars = {'boxbdd', 'parbdd', 'glue'}
    }
}
