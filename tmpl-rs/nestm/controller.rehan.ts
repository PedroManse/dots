#input PWD
#input service_name
#set ServiceName service_name [UpperCaseFirst()]
#filename {PWD}/controller.ts
#done
import {{
	Controller,
	HttpException,
	HttpStatus,
	Get, Post, Delete, Patch,
	Body, Param,
	ParseUUIDPipe,
	Request,
	UseGuards,
}} from '@nestjs/common';
import {{ {ServiceName}Service }} from './service';
import {{ ApiResponse, ApiTags }} from "@nestjs/swagger";

@ApiTags("{service_name}")
@Controller("{service_name}")
export class {ServiceName}Controller {{
	constructor(
		private readonly service: Service,
	) {{}}

	@ApiResponse({{ status: 200, description: "Found"}})
	@Get(':id')
	findOne(@Param('id', ParseUUIDPipe) id: string) {{
		return id;
	}}
}}
