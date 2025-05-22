local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

parser_config.plantuml = {
  install_info = {
    url = 'https://github.com/Decodetalkers/tree_sitter_plantuml.git',
    files = { 'src/parser.c' },
    branch = 'gh-pages',
  },
  filetype = 'puml',
}

vim.filetype.add {
  extension = {
    puml = 'plantuml',
    pu = 'plantuml',
    uml = 'plantuml',
    iuml = 'plantuml',
    plantuml = 'plantuml'
  },
}

require('preview').setup {
  previewers_by_ft = {
    plantuml = {
      name = 'plantuml_text',
      renderer = { type = 'buffer', opts = { split_cmd = 'vsplit' } },
    },
  },
  render_on_write = false,
}
