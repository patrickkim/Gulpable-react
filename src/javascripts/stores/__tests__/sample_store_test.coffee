describe 'TestStore', ->
  beforeEach ->
    @four = 1 + 3

  it 'trys to make this test work', ->
    expect(1 + 2).toEqual(3)
    expect(@four).toEqual(4)
