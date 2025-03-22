# tex-template

Minimal template for TeX.

## What is tex-template?

When you write a TeX document,
you need to compile the source code to a PDF to see how your document looks.
But the generated PDF file is not only large but also redundant
(contains information equivalent to the source code)
and should not be included in your repository.
But you may need to read it on the go or share it with someone.
Upload it to Google Drive?
No, use **tex-template**.

You can easily compile your TeX code to a PDF file locally,
and do not need to neither include it in your remote repository
nor upload it to remote storage.
All you need to do is to push your commit.
GitHub Actions will compile the source code to a PDF file
and add it to your release.

## Usage

### Prerequisites

* TeX compiler
* latexmk
* (optional) ChkTeX
* (optional) latexindent

### How to compile locally

1. Create your repository from tex-template
1. Edit `main.tex`
1. Run: `latexmk main.tex`

## Contributing

Pull requests are welcome.
For major changes,
please open an issue first to discuss what you would like to change.

## License

[MIT](/LICENSE)

