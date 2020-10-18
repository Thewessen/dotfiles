from IPython.terminal.prompts import Prompts, Token
import os

# Configuration file for ipython.
# By default, configuration files are fully featured Python scripts that can
# execute arbitrary code, the main usage is to set value on the configuration
# object c which exist in your configuration file.

class MyPrompt(Prompts):
    def in_prompt_tokens(self, cli=None):
        return [(Token.Prompt, '>>> ')]

    def continuation_prompt_tokens(self, cli=None, width=None):
        return [(Token.Text, '... ')]

    def out_prompt_tokens(self):
        return [(Token, '')]

c.InteractiveShell.editor = 'nvim'
c.InteractiveShell.colors = 'Linux'

c.InteractiveShellApp.exec_lines = [
    'import os',
    'os.system("fortune | cowsay")',
]

c.TerminalInteractiveShell.prompts_class = MyPrompt
