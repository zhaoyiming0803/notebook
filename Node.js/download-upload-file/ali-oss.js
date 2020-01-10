/**
 * 阿里云 OSS API
 */
const OSS = require('ali-oss');
const client = new OSS({
	region: 'oss-cn-beijing',
	accessKeyId: 'xx',
	accessKeySecret: 'xxx',
	bucket: 'xxx'
});

exports.put = async function putFile(filename) {
	const originDirName = process.env.NODE_ENV === 'production'
		? `screenshot`
		: `test-screenshot`;
	const result = await client.put(`${originDirName}/${Date.now()}.png`, filename);
	
	return result.url;
};