from IPython.terminal.prompts import Prompts, Token


class MyPrompt(Prompts):
    def in_prompt_tokens(self, cli=None):
        tokens = [
            (Token.Prompt, "λ   "),
        ]
        return tokens

    def out_prompt_tokens(self, cli=None):
        tokens = [
            (Token.Prompt, "Φ   "),
        ]
        return tokens


c.TerminalInteractiveShell.prompts_class = MyPrompt

from pygments.token import (
    Token,
    Keyword,
    Name,
    Comment,
    String,
    Error,
    Number,
    Operator,
    Whitespace,
    Generic,
)


c.TerminalIpython.exec_lines = [
    "import numpy as np",
    "import json",
    "import re",
    "from pprint import pprint",
    "import ipdb",
]

c.InteractiveShellApp.extensions = ["autoreload"]
c.InteractiveShellApp.exec_lines = ["%autoreload 2"]

c.TerminalIPythonApp.display_banner = False

colorlabel = "Linux"
c.InteractiveShell.colors = colorlabel
c.InteractiveShell.pdb = True
c.TerminalInteractiveShell.pager = "less"


c.InteractiveShell.display_completions = "multicolumn"
c.TerminalInteractiveShell.highlight_matching_brackets = True

black = "#282C34"
red = "#E06C75"
green = "#98C379"
yellow = "#E5C07B"
blue = "#61AFEF"
magenta = "#C678DD"
cyan = "#56B6C2"
grey = "#ABB2BF"

c.TerminalInteractiveShell.highlighting_style_overrides = {
    Whitespace: grey,
    Comment: f"italic {green}",
    Comment.Preproc: f"noitalic bold",
    Keyword: f"bold {magenta}",
    Keyword.Pseudo: f"nobold",
    Keyword.Type: f"bold {green}",
    Operator: grey,
    Operator.Word: f"bold {magenta}",
    Name.Builtin: f"#fff",
    Name.Function: cyan,
    Name.Class: yellow,
    Name.Namespace: f"bold {blue}",
    Name.Exception: f"bold {red}",
    Name.Variable: yellow,
    Name.Entity: f"bold {grey}",
    Name.Tag: f"bold {green}",
    Name.Decorator: f"bold {magenta}",
    String: red,
    String.Interpol: f"bold {red}",
    String.Escape: f"bold {yellow}",
    String.Regex: red,
    String.Symbol: yellow,
    String.Other: green,
    Number: grey,
    Generic.Heading: f"bold {blue}",
    Generic.Subheading: magenta,
    Generic.Deleted: red,
    Generic.Inserted: green,
    Generic.Error: red,
    Generic.Emph: f"italic",
    Generic.Strong: f"bold",
    Generic.Prompt: f"bold {blue}",
    Generic.Output: grey,
    Generic.Traceback: blue,
    Error: f"border:{red}",
    Token.Number: f"#ffffff",
    Token.Operator: f"noinherit",
    Token.String: green,
    Token.Name.Function: cyan,
    Token.Name.Class: f"bold {yellow}",
    Token.Name.Field: yellow,
    Token.Prompt: f"bold {green}",
    Token.Name.Namespace: f"bold {blue}",
    Token.Name.Field: yellow,
    Token.Prompt: f"{green} bold",
    Token.PromptNum: f"{grey} bold",
    Token.OutPrompt: f"{cyan} bold",
    Token.OutPromptNum: f"{cyan} bold",
}

c.InteractiveShell.autoformatter = "black"
c.InteractiveShell.autoindent = True
c.InteractiveShell.editing_mode = "vi"
