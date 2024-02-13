from setuptools import setup, find_packages

setup(
    name="stata_lsp",
    version="0.1.0",
    packages=find_packages(),
    entry_points={
        'console_scripts':[
            'stata_lsp:stata_lsp.__main__:main'
        ]
    }
)
