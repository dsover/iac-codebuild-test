function write(text){
    console.log(text)
    return text;
}

exports.handler = async (event, context) => {
    write('Hello World I can change!!!');
    return;
};
exports.write = write;