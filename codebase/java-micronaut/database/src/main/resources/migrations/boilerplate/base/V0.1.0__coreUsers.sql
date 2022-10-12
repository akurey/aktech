
CREATE TABLE IF NOT EXISTS ${schemaName}.core_users (
  UserId INT NOT NULL AUTO_INCREMENT,
  Username VARCHAR(50) NOT NULL,
  Email VARCHAR(50),
  Enabled BIT(1) NOT NULL DEFAULT(1),
  Deleted BIT(1) NOT NULL DEFAULT(0),
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (UserId)
);

CREATE TABLE IF NOT EXISTS ${schemaName}.core_userpasswords (
  UserPasswordId INT NOT NULL AUTO_INCREMENT,
  UserId INT NOT NULL,
  Password BINARY(255) NOT NULL,
  ChangePasswordToken VARCHAR(2048),
  Enabled BIT(1) NOT NULL DEFAULT(1),
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (UserPasswordId),
  CONSTRAINT FK_userpasswords_UserId FOREIGN KEY (UserId) REFERENCES core_users (UserId)
);

CREATE TABLE IF NOT EXISTS ${schemaName}.core_roles (
  RoleId INT NOT NULL AUTO_INCREMENT,
  RoleCode VARCHAR(50) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (RoleId)
);

CREATE TABLE IF NOT EXISTS ${schemaName}.core_userroles (
  UserId INT NOT NULL,
  RoleId INT NOT NULL,
  Deleted BIT(1) NOT NULL DEFAULT(0),
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (UserId, RoleId),
  CONSTRAINT FK_userroles_UserId FOREIGN KEY (UserId) REFERENCES core_users (UserId),
  CONSTRAINT FK_userroles_RoleId FOREIGN KEY (RoleId) REFERENCES core_roles (RoleId)
);

CREATE TABLE IF NOT EXISTS ${schemaName}.core_userrefreshtokens (
  RefreshTokenId BIGINT NOT NULL AUTO_INCREMENT,
  UserId INT NOT NULL,
  RefreshToken VARCHAR(2048) NOT NULL,
  ExpirationTime DATETIME NOT NULL,
  Enabled BIT(1) NOT NULL DEFAULT(1),
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (RefreshTokenId),
  CONSTRAINT FK_userrefreshtokens_UserId FOREIGN KEY (UserId) REFERENCES core_users (UserId)
);

CREATE TABLE IF NOT EXISTS ${schemaName}.core_usersessions (
  SessionId BIGINT NOT NULL AUTO_INCREMENT,
  RefreshTokenId BIGINT NOT NULL,
  UserId INT NOT NULL,
  AccessToken VARCHAR(2048) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (SessionId),
  CONSTRAINT FK_usersessions_RefreshTokenId FOREIGN KEY (RefreshTokenId) REFERENCES core_userrefreshtokens (RefreshTokenId),
  CONSTRAINT FK_usersessions_UserId FOREIGN KEY (UserId) REFERENCES core_users (UserId)
);
