function write(text){
    console.log(text)
    return text;
}

exports.handler = async (event, context) => {
    write('Hello World I still work');
    return;
};
exports.write = write;