describe "HAR grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-json")
    waitsForPromise ->
      atom.packages.activatePackage("language-har")

    runs ->
      grammar = atom.grammars.grammarForScopeName("source.json.har")

  it "parses the grammar", ->
    expect(grammar).toBeTruthy()
    expect(grammar.scopeName).toBe "source.json.har"

  it "tokenizes HAR", ->
    {tokens} = grammar.tokenizeLine '{"log": {"version": "1.2"}}'
    expect(tokens[0]).toEqual value: '{', scopes: ['source.json.har', 'meta.structure.dictionary.json', 'punctuation.definition.dictionary.begin.json']
    expect(tokens[2]).toEqual value: 'log', scopes: ['source.json.har', 'meta.structure.dictionary.json', 'meta.structure.dictionary.key.json', 'string.quoted.double.json']
    expect(tokens[4]).toEqual value: ':', scopes: ['source.json.har', 'meta.structure.dictionary.json', 'meta.structure.dictionary.value.json', 'punctuation.separator.dictionary.key-value.json']
