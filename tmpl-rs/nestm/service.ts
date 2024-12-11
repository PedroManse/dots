import { Injectable, HttpException, HttpStatus } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { LoginUserDto } from './dto/login-user.dto';
import { pbkdf2Sync } from "node:crypto";
import { PrismaService } from "../../util/prisma";
import { prismaWrap } from "../../util/prisma-expected-exception";
import { EnvService } from "../../util/env";
import { Agency, Permission } from "@prisma/client_gn";

@Injectable()
export class UserService {
	constructor(
		private readonly prisma: PrismaService,
		private readonly env: EnvService,
	) {}

	async create(createUserDto: CreateUserDto): Promise<{
		id: string,
		permission: Permission,
		agency: Agency,
	}> {
		const password = hashPassword(createUserDto.password, this.env.PASSWORD_SALT);
		return this.prisma.users.create({
			data: {...createUserDto, password, permission: "Worker"},
			select: {id: true, permission: true, agency: true},
		});
	}

	async login(loginUserDto: LoginUserDto) {
		const password = hashPassword(loginUserDto.password, this.env.PASSWORD_SALT);
		return prismaWrap(
			this.prisma.users.findUniqueOrThrow({
				where: {
					email: loginUserDto.email,
					password,
				},
				select: {id: true, permission: true, agency: true},
			}),
			`Email: ${loginUserDto.email}`,
			400,
			"Usuário não encontrado ou senha errada",
		);
	}

	async findOne(id: string) {
		return `This action returns user #${id}`;
	}
	async update(id: string, updateUserDto: UpdateUserDto) {
		return `This action updates the user #${id}`;
	}

	async remove(id: string) {
		return `This action removes the user #${id}`;
	}
}

function hashPassword(password: string, salt: string): Buffer {
	return pbkdf2Sync(password, salt, 10_000, 64, "sha512");
}

