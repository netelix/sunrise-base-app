# README

## PRETTIER

* install prettier and prettier-ruby with npm : 
```
npm install prettier
npm install --save-dev prettier @prettier/plugin-ruby
```

* open RubyMine preferences : Languages & Frameworks > Javascript > Prettier

Select prettier package `~/yourproject/web/node_modules/prettier`

* Create a `~/yourproject/.prettierrc` file with

```
{
  "overrides": [
    {
      "files": ".prettierrc",
      "options": { "parser": "json" }
    },
    {
      "files": "*.rb",
      "options": { "parser": "ruby" }
    }
  ]
}

```
