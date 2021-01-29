function write(text){
    console.log(text)
    return text;
}

exports.handler = async (event, context) => {
    write('Hello World, This is how it started');
    return;
};
exports.write = write;