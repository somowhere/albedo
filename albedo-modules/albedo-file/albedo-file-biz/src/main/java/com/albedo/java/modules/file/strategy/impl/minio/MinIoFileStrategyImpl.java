package com.albedo.java.modules.file.strategy.impl.minio;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.util.MapHelper;
import com.albedo.java.common.core.util.StrPool;
import com.albedo.java.modules.file.domain.FileDeleteBo;
import com.albedo.java.modules.file.domain.FileDo;
import com.albedo.java.modules.file.domain.FileGetUrlBo;
import com.albedo.java.modules.file.domain.enums.FileStorageType;
import com.albedo.java.modules.file.properties.FileServerProperties;
import com.albedo.java.modules.file.repository.FileRepository;
import com.albedo.java.modules.file.strategy.impl.AbstractFileStrategy;
import io.minio.*;
import io.minio.http.Method;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @author somewhere
 * @date 2020/11/22 5:00 下午
 */
@Slf4j
@Component("MIN_IO")

public class MinIoFileStrategyImpl extends AbstractFileStrategy {
	/**
	 * 桶占位符
	 */
	private static final String BUCKET_PARAM = "${bucket}";
	/**
	 * bucket权限-只读
	 */
	private static final String READ_ONLY = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"AWS\":[\"*\"]},\"Action\":[\"s3:GetBucketLocation\",\"s3:ListBucket\"],\"Resource\":[\"arn:aws:s3:::" + BUCKET_PARAM + "\"]},{\"Effect\":\"Allow\",\"Principal\":{\"AWS\":[\"*\"]},\"Action\":[\"s3:GetObject\"],\"Resource\":[\"arn:aws:s3:::" + BUCKET_PARAM + "/*\"]}]}";
	/**
	 * bucket权限-只读
	 */
	private static final String WRITE_ONLY = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"AWS\":[\"*\"]},\"Action\":[\"s3:GetBucketLocation\",\"s3:ListBucketMultipartUploads\"],\"Resource\":[\"arn:aws:s3:::" + BUCKET_PARAM + "\"]},{\"Effect\":\"Allow\",\"Principal\":{\"AWS\":[\"*\"]},\"Action\":[\"s3:AbortMultipartUpload\",\"s3:DeleteObject\",\"s3:ListMultipartUploadParts\",\"s3:PutObject\"],\"Resource\":[\"arn:aws:s3:::" + BUCKET_PARAM + "/*\"]}]}";
	/**
	 * bucket权限-读写
	 */
	private static final String READ_WRITE = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"AWS\":[\"*\"]},\"Action\":[\"s3:GetBucketLocation\",\"s3:ListBucket\",\"s3:ListBucketMultipartUploads\"],\"Resource\":[\"arn:aws:s3:::" + BUCKET_PARAM + "\"]},{\"Effect\":\"Allow\",\"Principal\":{\"AWS\":[\"*\"]},\"Action\":[\"s3:DeleteObject\",\"s3:GetObject\",\"s3:ListMultipartUploadParts\",\"s3:PutObject\",\"s3:AbortMultipartUpload\"],\"Resource\":[\"arn:aws:s3:::" + BUCKET_PARAM + "/*\"]}]}";
	private final MinioClient minioClient;

	public MinIoFileStrategyImpl(FileServerProperties fileProperties, MinioClient minioClient,
								 FileRepository fileMapper) {
		super(fileProperties, fileMapper);
		this.minioClient = minioClient;
	}

	@Override
	protected void uploadFile(FileDo fileDo, MultipartFile multipartFile, String bucket) throws Exception {
		//生成文件名
		String uniqueFileName = getUniqueFileName(fileDo);
		// 企业id/功能点/年/月/日/file
		String path = getPath(fileDo.getBizType(), uniqueFileName);

		bucket = StrUtil.isEmpty(bucket) ? fileProperties.getMinIo().getBucket() : bucket;
		boolean exists = minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucket).build());
		if (!exists) {
			minioClient.makeBucket(MakeBucketArgs.builder().bucket(bucket).build());
//            minioClient.setBucketPolicy(SetBucketPolicyArgs.builder().bucket(bucket).config(READ_WRITE.replace(BUCKET_PARAM, bucket)).build());
		}

		minioClient.putObject(PutObjectArgs.builder()
			.stream(multipartFile.getInputStream(), multipartFile.getSize(), PutObjectArgs.MIN_MULTIPART_SIZE)
			.object(path)
			.contentType(multipartFile.getContentType())
			.bucket(bucket)
			.build());

		fileDo.setBucket(bucket);
		fileDo.setPath(path);
		fileDo.setUniqueFileName(uniqueFileName);
		fileDo.setUrl(fileProperties.getMinIo().getUrlPrefix() + bucket + StrPool.SLASH + path);
		fileDo.setStorageType(FileStorageType.MIN_IO);
	}

	@SneakyThrows
	@Override
	public boolean delete(FileDeleteBo file) {
		String bucket = StrUtil.isEmpty(file.getBucket()) ? fileProperties.getMinIo().getBucket() : file.getBucket();
		minioClient.removeObject(RemoveObjectArgs.builder().bucket(bucket).object(file.getPath()).build());
		return true;
	}

	@Override
	@SneakyThrows
	public Map<String, String> findUrl(List<FileGetUrlBo> fileGets) {
		FileServerProperties.MinIo minIo = fileProperties.getMinIo();
		Set<String> publicBucket = fileProperties.getPublicBucket();

		Map<String, String> map = new LinkedHashMap<>(MapHelper.initialCapacity(fileGets.size()));
		for (FileGetUrlBo fileGet : fileGets) {
			String bucket = StrUtil.isEmpty(fileGet.getBucket()) ? minIo.getBucket() : fileGet.getBucket();

			try {
				if (CollUtil.isNotEmpty(publicBucket) && publicBucket.contains(bucket)) {
					StringBuilder url = new StringBuilder(minIo.getUrlPrefix())
						.append(fileGet.getBucket())
						.append(StrPool.SLASH)
						.append(fileGet.getPath());
					map.put(fileGet.getPath(), url.toString());
				} else {
					Integer expiry = minIo.getExpiry();
					String url = minioClient.getPresignedObjectUrl(GetPresignedObjectUrlArgs.builder()
						.bucket(bucket).object(fileGet.getPath()).method(Method.GET).expiry(expiry).build());
					map.put(fileGet.getPath(), url);
				}
			} catch (Exception e) {
				log.warn("加载文件url地址失败，请确保yml中第三方存储参数配置正确. bucket={}, , 文件名={} path={}", bucket, fileGet.getOriginalFileName(), fileGet.getPath(), e);
				map.put(fileGet.getPath(), StrPool.EMPTY);
			}
		}

		return map;
	}

}
