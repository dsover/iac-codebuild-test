function write(text){
    console.log(text)
    return text;
}

exports.handler = async (event, context) => {
    write('Hello World');
    return;
};
exports.write = write;