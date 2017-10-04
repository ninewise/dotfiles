local l = require('lexer') 
local token = l.token 
local S = lpeg.S

local M = {_NAME = 'lithaskell'} 

local haskell = l.load('haskell') 
local start_rule = token(l.STYLE_EMBEDDED, l.starts_line(S('><'))) 
local end_rule = token(l.STYLE_EMBEDDED, l.newline) 

local line = token(l.COMMENT, l.nonnewline^1)
M._rules = {
	{ 'comment', line }
}

l.embed_lexer(M, haskell, start_rule, end_rule) 

return M 