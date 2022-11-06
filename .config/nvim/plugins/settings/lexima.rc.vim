call lexima#set_default_rules()
let s:rules = {}
call lexima#add_rule({ 'char': '<', 'at': '\<\h\w*\%#', 'input_after': '>' })
call lexima#add_rule({ 'char': '<BS>',  'at': '<\%#>',      'delete': '>'})
" common
let s:rules._ = []
let s:rules._ += [
      \ { 'char': '<Tab>', 'at': '\%#\s*)',  'leave': ')'  },
      \ { 'char': '<Tab>', 'at': '\%#\s*\}', 'leave': '}'  },
      \ { 'char': '<Tab>', 'at': '\%#\s*\]', 'leave': ']'  },
      \ { 'char': '<Tab>', 'at': '\%#\s*>',  'leave': '>'  },
      \ { 'char': '<Tab>', 'at': '\%#\s*`',  'leave': '`'  },
      \ { 'char': '<Tab>', 'at': '\%#\s*"',  'leave': '"'  },
      \ { 'char': '<Tab>', 'at': '\%#\s*''', 'leave': '''' },
      \ ]

let s:rules._ += [
      \ { 'char': '<',     'at': '\<\h\w*\%#', 'input_after': '>' },
      \ { 'char': '<BS>',  'at': '<\%#>',      'delete': '>'      },
      \ { 'char': '>',     'at': '\%#>',       'leave': '>'       },
      \ { 'char': '<Tab>', 'at': '\%#\s*>',    'leave': '>'       },
      \ ]
