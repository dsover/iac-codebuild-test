const {write} = require('../handler/index');

test('it writes what it gets',()=>{
   const string = 'bob';
   expect(write(string)).toBe(string);
});