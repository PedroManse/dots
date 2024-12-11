import {
	Controller,
	HttpException,
	HttpStatus,
	Get, Post, Delete, Patch,
	Body, Param,
	ParseUUIDPipe,
	Request,
	UseGuards,
} from '@nestjs/common';
import { Service } from './service';
import { ApiResponse, ApiTags } from "@nestjs/swagger";

@ApiTags(/*TODO*/)
@Controller(/*TODO*/)
export class UserController {
	constructor(
		private readonly service: Service,
	) {}

	@ApiResponse({ status: 200, description: "Found"})
	@Get(':id')
	findOne(@Param('id', ParseUUIDPipe) id: string) {
		return id;
	}
}
