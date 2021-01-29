function write(text){
    console.log(text)
    return text;
}

exports.handler = async (event, context) => {
    write('Hello World, one more for tonight');
    return;
};
exports.write = write;