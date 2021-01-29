function write(text){
    console.log(text)
    return text;
}

exports.handler = async (event, context) => {
    write('Hello World next step integration');
    return;
};
exports.write = write;