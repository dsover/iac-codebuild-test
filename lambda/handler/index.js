function write(text){
    console.log(text)
    return text;
}

exports.handler = async (event, context) => {
    write('Hello World with a change to permissions for chris');
    return;
};
exports.write = write;