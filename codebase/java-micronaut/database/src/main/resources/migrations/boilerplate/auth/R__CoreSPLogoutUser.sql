DELIMITER // 
DROP PROCEDURE IF EXISTS ${schemaName}.CoreSPLogoutUser //
CREATE PROCEDURE ${schemaName}.CoreSPLogoutUser(
  IN pAccessToken VARCHAR(2048)
)
BEGIN
  DECLARE UNAUTHENTICATED_ERROR INT DEFAULT(51000);
  DECLARE UNAUTHENTICATED VARCHAR(50) DEFAULT 'The session token is invalid';
  DECLARE NO_ACCESS_TOKEN_ERROR INT DEFAULT(52000);
  DECLARE NO_ACCESS_TOKEN VARCHAR(50) DEFAULT 'The access token is invalid';
  
  DECLARE EXIT HANDLER FOR SQLEXCEPTION

  BEGIN
    GET DIAGNOSTICS CONDITION 1 @err_no = MYSQL_ERRNO, @message = MESSAGE_TEXT;
    SET @type = @err_no;
    ROLLBACK;
	SELECT SUBSTRING(@message, 1, 128) INTO @message;
	RESIGNAL SET MESSAGE_TEXT = @message, CONSTRAINT_CATALOG = @type;
  END;

  SET @sessionId = NULL;
  SET @refreshTokenId = NULL;
  SET @userId = NULL;
  
  IF ISNULL(pAccessToken) THEN
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = NO_ACCESS_TOKEN_ERROR, MESSAGE_TEXT = NO_ACCESS_TOKEN;
  END IF;
  
  START TRANSACTION;
  SELECT SessionId, RefreshTokenId, UserId INTO @sessionId, @refreshTokenId, @userId
  FROM core_usersessions
  WHERE (AccessToken = pAccessToken);
    
  IF ISNULL(@sessionId) THEN
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = UNAUTHENTICATED_ERROR, MESSAGE_TEXT = UNAUTHENTICATED;
  END IF;
	
  UPDATE core_userrefreshtokens SET ExpirationTime = NOW(), enabled = 0 WHERE RefreshTokenId = @refreshTokenId;
  COMMIT;
END
//