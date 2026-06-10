-- 中文说明：该补丁用于在 docker-compose 启动时，把 Nacos 中的默认 localhost 配置
-- 调整为容器网络可识别的服务名，并补齐 prod profile 的基础配置骨架。

USE `ry-config`;

DROP PROCEDURE IF EXISTS patch_compose_config;

DELIMITER $$
CREATE PROCEDURE patch_compose_config()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE current_data_id VARCHAR(255);
  DECLARE current_content LONGTEXT;
  DECLARE current_group_id VARCHAR(128);
  DECLARE current_desc VARCHAR(256);

  DECLARE config_cursor CURSOR FOR
    SELECT data_id, group_id, content, c_desc
    FROM config_info
    WHERE data_id IN (
      'application-dev.yml',
      'ruoyi-gateway-dev.yml',
      'ruoyi-auth-dev.yml',
      'ruoyi-monitor-dev.yml',
      'ruoyi-system-dev.yml',
      'ruoyi-gen-dev.yml',
      'ruoyi-job-dev.yml',
      'ruoyi-file-dev.yml'
    );

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN config_cursor;

  patch_loop: LOOP
    FETCH config_cursor INTO current_data_id, current_group_id, current_content, current_desc;
    IF done THEN
      LEAVE patch_loop;
    END IF;

    SET current_content = REPLACE(current_content, 'host: localhost', 'host: ruoyi-redis');
    SET current_content = REPLACE(current_content, 'url: jdbc:mysql://localhost:3306/ry-cloud', 'url: jdbc:mysql://ruoyi-mysql:3306/ry-cloud');
    SET current_content = REPLACE(current_content, 'gatewayUrl: http://localhost:8080', 'gatewayUrl: http://ruoyi-gateway:8080');
    SET current_content = REPLACE(current_content, 'http://127.0.0.1:9300', 'http://localhost:9300');
    SET current_content = REPLACE(current_content, 'path: D:/ruoyi/uploadPath', 'path: /home/ruoyi/uploadPath');

    UPDATE config_info
    SET content = current_content
    WHERE data_id = current_data_id;

    INSERT INTO config_info (
      data_id,
      group_id,
      content,
      md5,
      gmt_create,
      gmt_modified,
      src_user,
      src_ip,
      app_name,
      tenant_id,
      c_desc,
      c_use,
      effect,
      type,
      c_schema,
      encrypted_data_key
    )
    SELECT
      REPLACE(current_data_id, '-dev.yml', '-prod.yml'),
      current_group_id,
      current_content,
      MD5(current_content),
      NOW(),
      NOW(),
      'compose-init',
      '127.0.0.1',
      app_name,
      tenant_id,
      CONCAT(IFNULL(current_desc, ''), '（compose prod）'),
      c_use,
      effect,
      type,
      c_schema,
      encrypted_data_key
    FROM config_info
    WHERE data_id = current_data_id
      AND NOT EXISTS (
        SELECT 1
        FROM config_info existing
        WHERE existing.data_id = REPLACE(current_data_id, '-dev.yml', '-prod.yml')
      );
  END LOOP;

  CLOSE config_cursor;
END$$
DELIMITER ;

CALL patch_compose_config();

DROP PROCEDURE IF EXISTS patch_compose_config;
