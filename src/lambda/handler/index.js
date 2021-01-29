function write(text){
    console.log(text)
    return text;
}

exports.handler = async (event, context) => {
    write('Hello World, This is how it ended!!!');
    return;
};
exports.write = write;