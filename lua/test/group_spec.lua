
local Group = require('colorbuddy.group').Group
local groups = require('colorbuddy.group').groups

local Color = require('colorbuddy.color').Color
local colors = require('colorbuddy.color').colors

local styles = require('colorbuddy.style').styles

describe('Group object', function()
    Color.new('yellow', '#f0c674')
    Color.new('gray0', '#1d1f21')

    it('should send an nvim command', function()
        Group.new('test_01', colors.yellow, colors.gray0, styles.bold)
    end)

    it('should send a comma list', function()
        Group.new('test_02', colors.yellow, colors.gray0, styles.bold + styles.italic)
    end)

    it('should be able to add a group to fg and bg', function()
        Group.new('func', colors.yellow, colors.gray0, styles.bold)
        Group.new('italicFunction', groups.func, groups.func, styles.italic)
        Group.new('copyFunc', groups.func, groups.func, groups.func)
    end)

    it('should have its fg change when it\'s parent\'s fg changes', function()
        -- TODO: Test changing a color and having it update
        Color.new('changing', '#aabbcc')
        Group.new('changingFunc', colors.changing, colors.gray0)

        Color.new('changing', '#ffccff')
        Group.new('copyFunc', groups.changingFunc, groups.changingFunc)
        assert.are.same(colors.changing, groups.copyfunc.fg)
        assert.are.same('#ffccff', groups.copyfunc.fg:to_rgb())
    end)
end)
